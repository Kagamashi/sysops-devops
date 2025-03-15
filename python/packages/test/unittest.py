''' Unit testing is a way to test individual units of code (functions,methods) to ensure they work as expected.

unittest module is Python built-in testing framework
test cases are written as classes that inherit from unittest.TestCase 
individual tests are defined as methods whose names begin with test_
    setUp(): Optional method that runs before each test.
    tearDown(): Optional method that runs after each test.
    assert methods to check test results

run all tests               python -m unittest discover
run specific test file      python -m unittest test_file.py
run specific test case      python -m unittest test_file.TestClass.test_method
'''
import unittest

def add(a, b):
    return a + b

class TestMathOperations(unittest.TestCase):

    def test_add(self):
        self.assertEqual(add(2, 3), 5)
        self.assertEqual(add(-1, 1), 0)

    def test_add_negative(self):
        self.assertEqual(add(-2, -3), -5)

if __name__ == '__main__':
    unittest.main()
# run with: python test_file.py


''' Mocking is a technique used in unit testing to replace parts of our system under test with mock objects.
This is useful when we want to simulate behavior without invoking actual external systems (like databases, APIs)

unittest.mock module provided a way to mock objects '''

''' mocking a function inside a module '''
import unittest
from unittest import TestCase
from unittest.mock import patch

# Function to test
def get_data_from_api():
    return "Original data from API"

class TestMocking(TestCase):

    @patch('__main__.get_data_from_api')  # Mocking the function
    def test_get_data_from_api(self, mock_get):
        mock_get.return_value = "Mocked data from API"  # Simulating API response

        result = get_data_from_api()
        self.assertEqual(result, "Mocked data from API")

if __name__ == "__main__":
    unittest.main()


''' mocking an objects method '''
class Service:
    def fetch_data(self):
        # Simulate a call to an external service
        return "Real data from service"

class TestService(TestCase):

    @patch.object(Service, 'fetch_data')  # Mocking the method in Service
    def test_fetch_data(self, mock_fetch):
        mock_fetch.return_value = "Mocked data"
        service = Service()
        self.assertEqual(service.fetch_data(), "Mocked data")

if __name__ == "__main__":
    unittest.main()


'''
Assertions are used in unit tests to check whether the actual output matches the expected output.
If assertion fails, the test fails.

assertEqual(a, b): Check if a is equal to b.
assertNotEqual(a, b): Check if a is not equal to b.
assertTrue(x): Check if x is True.
assertFalse(x): Check if x is False.
assertIs(a, b): Check if a is b (same object).
assertIsNone(x): Check if x is None.
assertIn(a, b): Check if a is in b (e.g., substring in string, item in list).
'''

import unittest
class TestAssertions(unittest.TestCase):

    def test_assertions(self):
        self.assertEqual(3 + 2, 5)  # Passes
        self.assertNotEqual(3 + 2, 6)  # Passes
        self.assertTrue(3 < 5)  # Passes
        self.assertFalse(3 > 5)  # Passes
        self.assertIsNone(None)  # Passes
        self.assertIn(3, [1, 2, 3, 4])  # Passes

if __name__ == "__main__":
    unittest.main()
