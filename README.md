
# a199-flutter-expert-project

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.



## 1. Installation

### 1.1. Installing in Ubuntu
```sh
sudo apt-get update -qq -y
sudo apt-get install lcov -y
```

### 1.2. Installing in Mac
```sh
brew install lcov
```

## 2. Run tests, generate coverage files and convert to HTML
```sh
flutter test --coverage
genhtml lcov.info -o coverage/html
```

## 3. Open coverage report in browser
```sh
open index.html
```

> **Note:** This way you can add it to CircleCI artifacts and Coveralls as well.

FLUTTER VERSION : 3.24.4
