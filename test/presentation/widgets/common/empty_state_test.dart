import 'package:easyexam/presentation/widgets/common/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmptyState', () {
    testWidgets('should render icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(icon: Icons.inbox, title: 'No Data'),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('should render title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(icon: Icons.inbox, title: 'No Data'),
          ),
        ),
      );

      expect(find.text('No Data'), findsOneWidget);
    });

    testWidgets('should render message when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.inbox,
              title: 'No Data',
              message: 'There is no data to display',
            ),
          ),
        ),
      );

      expect(find.text('There is no data to display'), findsOneWidget);
    });

    testWidgets('should not render message when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(icon: Icons.inbox, title: 'No Data'),
          ),
        ),
      );

      expect(find.text('There is no data to display'), findsNothing);
    });

    testWidgets('should render action when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.inbox,
              title: 'No Data',
              action: ElevatedButton(
                onPressed: () {},
                child: Text('Refresh'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Refresh'), findsOneWidget);
    });

    testWidgets('should center content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(icon: Icons.inbox, title: 'No Data'),
          ),
        ),
      );

      expect(find.byType(Center), findsWidgets);
    });
  });

  group('EmptyStates', () {
    testWidgets('noData should render correct content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noData(),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('No Data'), findsOneWidget);
      expect(find.text('There is no data to display'), findsOneWidget);
    });

    testWidgets('noExams should render correct content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noExams(),
          ),
        ),
      );

      expect(find.byIcon(Icons.quiz_outlined), findsOneWidget);
      expect(find.text('No Exams'), findsOneWidget);
      expect(find.text('There are no exams available'), findsOneWidget);
    });

    testWidgets('noStudents should render correct content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noStudents(),
          ),
        ),
      );

      expect(find.byIcon(Icons.people_outline), findsOneWidget);
      expect(find.text('No Students'), findsOneWidget);
      expect(find.text('There are no students registered'), findsOneWidget);
    });

    testWidgets('noResults should render correct content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noResults(),
          ),
        ),
      );

      expect(find.byIcon(Icons.assessment_outlined), findsOneWidget);
      expect(find.text('No Results'), findsOneWidget);
      expect(find.text('There are no results to display'), findsOneWidget);
    });

    testWidgets('noHistory should render correct content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noHistory(),
          ),
        ),
      );

      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
      expect(find.text('No History'), findsOneWidget);
      expect(find.text('You have not taken any exams yet'), findsOneWidget);
    });

    testWidgets('noData should render action when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStates.noData(
              action: ElevatedButton(
                onPressed: () {},
                child: Text('Add Data'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Add Data'), findsOneWidget);
    });
  });
}
