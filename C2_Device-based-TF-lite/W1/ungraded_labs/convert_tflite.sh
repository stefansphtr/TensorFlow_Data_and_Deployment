#!/usr/bin/env bash

# Saving with the command-line from a SavedModel
tflite_convert --saved_model_dir=/tmp/mobilenet/saved_model --output_file=/tmp/mobilenet/mobilenet.tflite

# Saving with the command-line from a Keras model
tflite_convert --keras_model_file=/tmp/mobilenet/keras_model.h5 --output_file=/tmp/mobilenet/mobilenet.tflite