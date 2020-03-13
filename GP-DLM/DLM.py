import configuration
from keras.utils import np_utils
from keras.layers import *
from keras.models import *
from keras.optimizers import Adam
from keras.regularizers import l2,l1
from keras.initializers import *


def attention_3d_block_f(inputs):
    # a = Permute((2, 1))(inputs)
    a = Dense(input_dim+1, activation='relu', use_bias=True)(inputs)
    a = Activation('softmax')(a)
    # a_probs = Permute((2, 1), name='attention_vec')(a)
    output_attention_mul = multiply([inputs, a], name='attention_mul')
    return output_attention_mul


def attention_3d_block_m(inputs):
    a = Permute((2, 1))(inputs)
    a = Dense(12, activation='relu', use_bias=True)(a)
    a = Activation('softmax')(a)
    a_probs = Permute((2, 1), name='attention_vec1')(a)
    output_attention_mul = multiply([inputs, a_probs], name='attention_mul1')
    return output_attention_mul
# build RNN model with attention

def dlm(train_x,train_y,test_x,test_y,dim1,dim2,dim3,dropout_1,batchsize,epoch):
    inputs2 = Input(shape=(12, dim1))
    attention_mul1 = attention_3d_block_f(inputs2)
    # attention_mul2 = attention_3d_block_m(inputs2)
    lstm_out2 = LSTM(dim2, return_sequences=False, activation='relu', dropout=0.01, kernel_initializer=he_normal(),
                     name='bilstm1')(
        attention_mul1)

    drop2 = Dropout(dropout_1)(lstm_out2)
    output1 = Dense(dim3, kernel_initializer=he_normal(), activation='relu')(drop2)
    output1 = Dense(1, kernel_initializer=he_normal())(output1)
    model2 = Model(inputs=inputs2, outputs=output1)
    model2.compile(loss='mape', optimizer='adam')
    #model2.summary()
    model2.fit(train_x,train_y, batch_size=batchsize, epochs=epoch, callbacks=cbks, verbose=1,
               validation_data=(test_x,test_y))
    return model2