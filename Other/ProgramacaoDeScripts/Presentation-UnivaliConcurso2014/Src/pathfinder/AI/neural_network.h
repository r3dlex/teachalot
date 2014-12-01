/*
 * neuralNetwork.h
 *
 *  Created on: 18/05/2010
 *      Author: zce
 */

#ifndef NEURALNETWORK_H_
#define NEURALNETWORK_H_

namespace AI {

class NeuralNetwork {
public:
	NeuralNetwork();
	virtual ~NeuralNetwork();

    NeuralNetwork(int numCamadas, int* neuroniosPorCamada, int* funcaoDaCamada);

	void propagate(float* input, float* output);

	void teach(float* correctOutput);

private:
    int _numLayers;
    int* _neuronsPerLayer;
    int* _layerFunctions;
    float* _weights;

    int* _weightsOffsets;
    int _numWeights;

    int* _neuronsOffsets;
    int _numNeurons;
    int _numInputs;
    int _numOutputs;

    float* _net;
    float* _out;
    float* _errors;

    static const float learnRate = 0.01;
};

}

#endif /* NEURALNETWORK_H_ */
