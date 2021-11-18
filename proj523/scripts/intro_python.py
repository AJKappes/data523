import pandas as pd
import numpy as np

numbers = [1, 2, 3]
numbers[0]

for num in numbers:

    print(num)

numbers.append(4)
print(numbers)

animals = ['cat', 'dog', 'clouded_leopard']
animals[1]

for anim in animals:
    
    print(anim)

for num, anim in zip(numbers, animals):
    
    print(num, anim)

animals.append('snow_leopard')

for num, anim in zip(numbers, animals):
    
    print(f'We observed {num} {anim} in ')

np.array([[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]])

np.array([1, 2, 3, 4, 5, 6, 7, 8, 9])

a = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9]).reshape(3, 3)
a.shape

n, p = 100, 3
print(f'we have {n} rows and {p} covariates')

x = np.random.normal(size = n*p).reshape(n, p)
x.shape

B = np.array([-2, 4, 7]).reshape(p, 1)

y = np.dot(x, B) + np.random.normal(size = n).reshape(n, 1)

Bhat = np.linalg.inv(x.T.dot(x)).dot(x.T.dot(y))
Bhat.flatten()
Bhat.flatten().shape

est_table = pd.DataFrame({'Beta': B.flatten(),
                          'Beta_hat': Bhat.flatten()})
est_table

# dictionaries and list comprehension

translation = {'one': 'first', 'two': 'second'}
translation['one']

rev = {'first': 'one', 'second': 'two'}
rev['second']

rev['third'] = 'three'
rev
rev.items()
rev.keys()
rev.values()

for key, value in rev.items():
    
    print(f'{key} assigned to {value}')

[k for k in rev.keys()]
[k for k in rev.keys() if 'd' in k]

# function

def get_B(dep, exp):
    
    xtxi = np.linalg.inv(exp.T.dot(exp))
    xty = exp.T.dot(dep)
    
    return xtxi.dot(xty)

get_B(y, x)

# what is the downside of this? defensive programming?

df = pd.DataFrame(np.concatenate((y, x), axis=1),
                 columns=['y', 'x1', 'x2', 'x3'])

df.columns
[var for var in df.columns if 'x' in var]
df[[var for var in df.columns if 'x' in var]]
df['y']
x_arr = df[[var for var in df.columns if 'x' in var]].to_numpy()
y_arr = df['y'].to_numpy().reshape(n, 1)

get_B(y_arr, x_arr)
df

def get_B_better(dep, exp, data):
    
    x = data[exp].to_numpy()
    y = data[dep].to_numpy().reshape(x.shape[0], 1)
    xtxi = np.linalg.inv(x.T.dot(x))
    xty = x.T.dot(y)
    
    return xtxi.dot(xty)

get_B_better('y', [var for var in df.columns if 'x' in var], df)

myfunc = lambda x: x*5
myfunc(2)


