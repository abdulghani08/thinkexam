import 'base_entity.dart';
import 'exam.dart';

class DashboardSummary extends BaseEntity {
  final int totalTeachers;
  final int totalStudents;
  final int totalClasses;
  final int totalSubjects;
  final int totalExams;
  final int activeExams;
  final int completedExams;
  final int upcomingExams;
  final int totalSubmissions;
  final double averageScore;
  final double highestScore;
  final double lowestScore;
  final List<Exam> recentExams;
  final List<Exam> upcomingExamList;

  const DashboardSummary({
    this.totalTeachers = 0,
    this.totalStudents = 0,
    this.totalClasses = 0,
    this.totalSubjects = 0,
    this.totalExams = 0,
    this.activeExams = 0,
    this.completedExams = 0,
    this.upcomingExams = 0,
    this.totalSubmissions = 0,
    this.averageScore = 0,
    this.highestScore = 0,
    this.lowestScore = 0,
    this.recentExams = const [],
    this.upcomingExamList = const [],
  });

  @override
  List<Object?> get props => [
    totalTeachers,
    totalStudents,
    totalClasses,
    totalSubjects,
    totalExams,
    activeExams,
    completedExams,
    upcomingExams,
    totalSubmissions,
    averageScore,
    highestScore,
    lowestScore,
    recentExams,
    upcomingExamList,
  ];
}
