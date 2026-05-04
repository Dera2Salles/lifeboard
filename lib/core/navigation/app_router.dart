import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/persons/screens/persons_list_screen.dart';
import '../../features/persons/screens/add_person_screen.dart';
import '../../features/persons/screens/person_profile_screen.dart';
import '../../features/habits/screens/habits_screen.dart';
import '../../features/progression/screens/progression_screen.dart';
import '../../features/my_profile/screens/my_profile_screen.dart';
import '../../shared/widgets/main_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardScreen(),
          ),
        ),
        GoRoute(
          path: '/persons',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PersonsListScreen(),
          ),
        ),
        GoRoute(
          path: '/habits',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HabitsScreen(),
          ),
        ),
        GoRoute(
          path: '/progression',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProgressionScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MyProfileScreen(),
          ),
        ),
      ],
    ),
    // Routes sans shell (full screen)
    GoRoute(
      path: '/persons/add',
      builder: (context, state) => const AddPersonScreen(),
    ),
    GoRoute(
      path: '/persons/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PersonProfileScreen(personId: id);
      },
    ),
  ],
);
