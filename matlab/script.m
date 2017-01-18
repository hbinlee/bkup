n=300;

load('cassini_200.csv')
field_script(cassini_200,n,'cassini200')

load('data_circle_200.csv')
field_script(data_circle_200,n,'datacircle200')

load('iris_petal.csv')
field_script(iris_petal,n,'irispetal')

load('sample.csv')
field_script(sample,n,'irissepal')

load('synth1.mat')
field_script(X,n,'synth1')

load('synth2.mat')
field_script(X,n,'synth2')

load('synth3.mat')
field_script(X,n,'synth3')