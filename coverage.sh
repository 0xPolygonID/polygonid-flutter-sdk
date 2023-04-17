## ONLY FOR MAC OR LINUX 


# Install https://pub.dev/packages/remove_from_coverage
pub global activate remove_from_coverage

# Effective test coverage
flutter test --coverage

# Remove Generate dart files
remove_from_coverage -f coverage/lcov.info -r '.g.dart$'

# Generate coverage info
genhtml -o coverage coverage/lcov.info 

# Open to see coverage info
open coverage/index.html