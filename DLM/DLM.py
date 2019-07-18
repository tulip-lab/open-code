# -*- coding: utf-8 -*-

from keras.layers import merge
from keras.layers.core import *
from keras.models import *

from keras.layers import Dense
from keras.layers import LSTM

from keras import initializers



def attention_block(inputs,TIME_STEPS,INPUT_DIM):
  
    input_dim = int(inputs.shape[2])
    a = Permute((2, 1))(inputs)
    a = Dense(TIME_STEPS, activation='tanh',use_bias=True)(a)
    a = Dense(TIME_STEPS, activation='softmax')(a)
    a_probs = Permute((2, 1), name='attention_vec')(a)
    output_attention_mul = merge([inputs, a_probs], name='attention_mul', mode='mul')
    return output_attention_mul      
  
def model_attention_applied_before_lstm(TIME_STEPS,INPUT_DIM,lstm_unit,drop_rate,dense_unit):
 
    inputs = Input(shape=(TIME_STEPS, INPUT_DIM,))
    attention_mul = attention_block(inputs,TIME_STEPS,INPUT_DIM)
    attention_mul = LSTM(lstm_unit, return_sequences=False)(attention_mul)
    dropout = Dropout(drop_rate)(attention_mul)
    output = Dense(dense_unit, activation='relu')(attention_mul)
    output = Dense(1, activation='relu')(output)
    model = Model(input=[inputs], output=output)
    return model
  
  
def build_model(tranin_X,train_Y,lstm_unit,drop_rate,dense_unit,batch_size,epochs):
  
    outputs =  train_Y.reshape(train_Y.shape[0],1)
    TIME_STEPS = tranin_X.shape[1]
    INPUT_DIM  = tranin_X.shape[2]
    attention_lstm__model = model_attention_applied_before_lstm(TIME_STEPS,
                                                         INPUT_DIM,
                                                         lstm_unit,
                                                         drop_rate,
                                                         dense_unit)
    attention_lstm__model.compile(loss = 'mae',optimizer='adam')
    attention_lstm__model.fit([tranin_X], 
                              outputs, 
                              epochs=epochs, 
                              batch_size=batch_size,
                              #validation_data=([lstmtest_X],test_Y.reshape(test_Y.shape[0],1))
                              )
    return attention_lstm__model
    