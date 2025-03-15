''' pytest is another popular testing framework that simplifies test writing and offers more functionality compared to unittest
  Functions for test cases are written with the prefix test_.
  You don’t need to create a class, making it more concise.
'''

import _tools.python.packages.test.pytest as pytest

def test_addition():
    assert 2 + 2 == 4

def test_subtraction():
    assert 5 - 3 == 2

# fixtures allows setup and teardown logic before and after tests
@pytest.fixture
def sample_data():
    return {"name": "Alice", "age": 30}

def test_sample_data(sample_data):
    assert sample_data["name"] == "Alice"
    assert sample_data["age"] == 30

# parameterization runs the same test with different inputs
@pytest.mark.parametrize("a, b, result", [
    (2, 3, 5),
    (5, 5, 10),
    (10, -5, 5),
])
def test_addition(a, b, result):
    assert a + b == result
