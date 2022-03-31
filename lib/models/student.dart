//A class definition for a course
class Course {
  final String _courseDescription;
  final String _courseCode;
  final int _courseUnit;
  final String _courseStatus;
  final int _courseScore;
  late final int _courseGP;
  late final int _courseWGP;

  late final Function _courseGPGetter;

//A constructor definition for the course requiring ...
//the course description, course code, course unit, ...
//course status, and the score in the course compulsorily
  Course({
    required String courseDescription,
    required String courseCode,
    required int courseUnit,
    required String courseStatus,
    required int courseScore,
    required Function courseGPGetter,
  })  : _courseDescription = courseDescription,
        _courseCode = courseCode,
        _courseUnit = courseUnit,
        _courseStatus = courseStatus,
        _courseScore = courseScore,
        _courseGPGetter = courseGPGetter {
    _courseGPCalculate();
  }

  void _courseGPCalculate() {
    _courseGP = _courseGPGetter(_courseScore);
    _courseWGPCalculate();
  }

  void _courseWGPCalculate() => _courseWGP = _courseGP * _courseUnit;

  int courseUnitGetter() => _courseUnit;

  @override
  String toString() {
    return '\tCourse description: $_courseDescription\n'
        '\tCourse code: $_courseCode\n'
        '\tCourse unit: $_courseUnit\n'
        '\tCourse status: $_courseStatus\n'
        '\tCourse score: $_courseScore\n'
        '\tCourseGP: $_courseGP\n'
        '\tCourseWGP: $_courseWGP\n';
  }
}

//  Class definition for Student Object

class Student {
  final int _matricNO;
  final String _studentName;
  final String _courseOfStudy;
  final String _faculty;
  final bool _sex;
  final int _yearOfAdmission;
  final List<Course> _courses = [];
  final int _gradeSystem;
  int _studentCUR = 0;
  int _studentCUP = 0;
  int _studentTWGP = 0;
  double _studentCGPA = 0.0;

  Student({
    required int matricNO,
    required String studentName,
    required String courseOfStudy,
    required String faculty,
    required bool sex,
    required int yearOfAdmission,
    required int gradeSystem,
  })  : _matricNO = matricNO,
        _studentName = studentName,
        _courseOfStudy = courseOfStudy,
        _faculty = faculty,
        _sex = sex,
        _yearOfAdmission = yearOfAdmission,
        _gradeSystem = gradeSystem;

  Function? _gradeGPGetter() {
    switch (_gradeSystem) {
      case 4:
        return ((int score) {
          if (score >= 70) {
            return 4;
          } else if (score >= 60) {
            return 3;
          } else if (score >= 50) {
            return 2;
          } else if (score >= 45) {
            return 1;
          } else {
            return 0;
          }
        });
      case 7:
        return ((int score) {
          if (score >= 70) {
            return 7;
          } else if (score >= 65) {
            return 6;
          } else if (score >= 60) {
            return 5;
          } else if (score >= 55) {
            return 4;
          } else if (score >= 50) {
            return 3;
          } else if (score >= 45) {
            return 2;
          } else if (score >= 40) {
            return 1;
          } else {
            return 0;
          }
        });
      default:
        return null;
    }
  }

  void addCourse({
    required String courseDescription,
    required String courseCode,
    required int courseUnit,
    required String courseStatus,
    required int courseScore,
  }) {
    Course course = Course(
      courseDescription: courseDescription,
      courseCode: courseCode,
      courseUnit: courseUnit,
      courseStatus: courseStatus,
      courseScore: courseScore,
      courseGPGetter: _gradeGPGetter()!,
    );
    _courses.add(course);
    updateStudent(course);
  }

  void updateStudent(Course course) {
    _studentCURCalculate(course);
    _studentCUPCalculate(course);
    _studentTWGPCalculate(course);
    _studentCGPACalculate(course);
  }

  void _studentCURCalculate(Course course) => _studentCUR += course._courseUnit;

  void _studentCUPCalculate(Course course) => (course._courseScore >= 45)
      ? _studentCUP += course._courseUnit
      : _studentCUP;

  void _studentTWGPCalculate(Course course) =>
      _studentTWGP += course._courseWGP;

  void _studentCGPACalculate(Course course) =>
      _studentCGPA = _studentTWGP / _studentCUR;

  String printCourses() {
    String stringCourses = '';
    for (var course in _courses) {
      stringCourses += course.toString() + '\n';
    }
    return stringCourses;
  }

  @override
  String toString() {
    return 'Matriculation Number: $_matricNO\n'
        'Student name: $_studentName\n'
        '\nCourse of study: $_courseOfStudy\n'
        'Faculty: $_faculty\n'
        'Sex: $_sex\n'
        'Year of admission: $_yearOfAdmission\n\n'
        'final List<Course> courses:\n'
        '${printCourses()}'
        'Student cummulative Units Required: $_studentCUR\n'
        'Student cummultive Units Passed: $_studentCUP\n'
        'Student Total Weighed grade point: $_studentTWGP\n'
        'student Cummulative Grade Point Average: $_studentCGPA';
  }
}
