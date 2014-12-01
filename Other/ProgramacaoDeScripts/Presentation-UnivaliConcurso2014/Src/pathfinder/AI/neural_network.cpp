/*
 * neuralNetwork.cpp
 *
 *  Created on: 18/05/2010
 *      Author: zce
 */

#include "neural_network.h"

#include <sys/time.h>

#include <boost/random.hpp>

#include <iostream>
#include <fstream>

using namespace std;

namespace {
	struct Random {
			float operator()() {
					return u();
			}

			Random()
					: u(rng)
			{
					timeval tv;
					gettimeofday(&tv, 0);

					rng.seed(boost::mt19937::result_type(tv.tv_usec));

					u = boost::uniform_01<boost::mt19937, float>(rng);
			}

			boost::mt19937 rng;
			boost::uniform_01<boost::mt19937, float> u;
	};

	struct Function {
			virtual float operator()(float x) const = 0;

			virtual float derivate(float x) const = 0;
	};

	struct Sigmoidal: public Function {
			float operator()(float x) const {
					float v = 1.0 / (1 + expf(-x));
					if (isnan(v) || isinf(v)) {
							v = 1.0;
					}
					return v;
			}

			float derivate(float x) const {
					return (1 - (1 / (1 + expf(-x)))) / (1 + expf(-x));
			}
	};

	struct TangenteHiperbolica: public Function {
			float operator()(float x) const {
					float v = tanhf(x);
					if (isnan(v) || isinf(v)) {
							v = 1.0;
					}
					return v;
			}

			float derivate(float x) const {
					return 1 - tanhf(x) * tanhf(x);
			}
	};

	static Random rnd;
	static const Function* functions[] = { new Sigmoidal(), new TangenteHiperbolica() };
}

namespace AI {

NeuralNetwork::NeuralNetwork(int numLayers, int* neuronsPerLayer, int* layerFunctions)
		: _numLayers(numLayers), _neuronsPerLayer(neuronsPerLayer),
						_layerFunctions(layerFunctions)
{
	_numInputs = neuronsPerLayer[0];
	_numOutputs = neuronsPerLayer[numLayers - 1];

	_weightsOffsets = new int[numLayers];
	_weightsOffsets[0] = 0;

	_neuronsOffsets = new int[numLayers];
	_neuronsOffsets[0] = 0;

	_numWeights = neuronsPerLayer[0];
	_numNeurons = neuronsPerLayer[0];
	for (int i = 1; i < numLayers; ++i) {
		_weightsOffsets[i] = _numWeights;
		_neuronsOffsets[i] = _numNeurons;
		_numWeights += neuronsPerLayer[i] * neuronsPerLayer[i-1];
		_numNeurons += neuronsPerLayer[i];
	}

	_weights = new float[_numWeights];
	_net = new float[_numNeurons];
	_out = new float[_numNeurons];
	_errors = new float[_numNeurons];

	for (int i = 0; i < _numWeights; ++i) {
		_weights[i] = rnd() * 2 - 1;
	}
}

NeuralNetwork::~NeuralNetwork() {
	delete [] _weights;
	delete [] _net;
	delete [] _out;
	delete [] _errors;
}

void NeuralNetwork::propagate(float* input, float* output) {
	for (int i = 0; i < _numInputs; i++) {
		_net[i] = input[i];
		_out[i] = input[i];
	}

	for (int i = 1; i < _numLayers; i++) {
		for (int j = 0; j < _neuronsPerLayer[i]; j++) {
			int neuronOffset = _neuronsOffsets[i] + j;
			_net[neuronOffset] = 0;

			for (int k = 0; k < _neuronsPerLayer[i-1]; k++) {
				float weight = _weights[_weightsOffsets[i] + j * _neuronsPerLayer[i-1] + k];
				float in = _out[_neuronsOffsets[i-1] + k];

				_net[neuronOffset] += weight * in;
			}

			const Function* f = functions[_layerFunctions[i]];
			_out[neuronOffset] = (*f)(_net[neuronOffset]);
		}
	}

	copy(_out + _numNeurons - _numOutputs, _out + _numNeurons, output);
}

void NeuralNetwork::teach(float* correctOutput) {
	int idxLastLayer = _neuronsOffsets[_numLayers-1];
	for (int i = 0; i < _numOutputs; ++i) {
		_errors[idxLastLayer + i] = correctOutput[i] - _out[idxLastLayer + i];
	}

	for (int i = 0; i < _numNeurons - _numOutputs; ++i) {
		_errors[i] = 0;
	}

	for (int i = _numLayers - 1; i > 0; --i) {
		int idxPreviousLayer = _neuronsOffsets[i-1];
		int idxLayer = _neuronsOffsets[i];
		for (int j = 0; j < _neuronsPerLayer[i]; ++j) {
			const Function* f = functions[_layerFunctions[i]];
			float deriv = f->derivate(_net[idxLayer + j]);

			float delta = _errors[idxLayer + j] * deriv;
			float deltaLearn = learnRate * delta;

			for (int k = 0; k < _neuronsPerLayer[i-1]; ++k) {
				float* weight = &_weights[_weightsOffsets[i] + j * _neuronsPerLayer[i-1] + k];

				_errors[idxPreviousLayer + k] += delta * (*weight);
				*weight += deltaLearn * _out[idxPreviousLayer + k];
			}
		}
	}
}

}
