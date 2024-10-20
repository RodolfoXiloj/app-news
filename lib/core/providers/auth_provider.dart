import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/core/widgets/custom_dialog.dart';
import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/features/auth/repository/auth_repo.dart';
import '../services/auth_service.dart';

// Proveedor del servicio de autenticación
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Proveedor del cliente de API
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient('https://newsapi.org/v2/');
});

// Proveedor del repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;
  final AuthRepository _authRepository;

  AuthNotifier(this._authService, this._authRepository)
      : super(AsyncValue.data(null)) {
    _init();
  }

  void _init() {
    state = AsyncValue.data(_authService.currentUser);
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    state = AsyncValue.loading();
    try {
      final user = await _authService.registerWithEmail(email, password);
      if (user == null) {
        throw Exception(
            'Error en el registro. Inténtalo de nuevo.'); // Lanza un error si el usuario es nulo
      }
      state = AsyncValue.data(user);
      _showCustomDialog(
        context,
        DialogType.success,
        'Registro Exitoso',
        'Tu cuenta ha sido creada con éxito.',
      );
      // Espera a que el usuario cierre el diálogo antes de navegar
      /* await Future.delayed(Duration(seconds: 2)); // Espera 2 segundos

      Navigator.of(context).pushReplacementNamed(
          '/login'); */
      Navigator.pop(context);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      _showCustomDialog(
        context,
        DialogType.error,
        'Error',
        e.toString(),
      );
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    state = AsyncValue.loading();
    try {
      final user = await _authService.signInWithEmail(email, password);

      if (user == null) {
        throw Exception(
            'Error en el inicio de sesion. Inténtalo de nuevo.'); // Lanza un error si el usuario es nulo
      }
      state = AsyncValue.data(user);
      /* _showCustomDialog(
        context,
        DialogType.success,
        'Inicio Exitoso',
        'Bienvenido de nuevo.',
      );
      // Espera a que el usuario cierre el diálogo antes de navegar
      await Future.delayed(Duration(seconds: 2)); // Espera 2 segundos */

      Navigator.of(context).pushReplacementNamed(
          '/home'); // Reemplaza '/home' con la ruta de tu pantalla principal
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      _showCustomDialog(
        context,
        DialogType.error,
        'Error',
        e.toString(),
      );
    }
  }
/*   Future<void> signIn(String email, String password) async {
    state = AsyncValue.loading();
    try {
      //await _authRepository.login(email, password);
      final user = await _authService.signInWithEmail(email, password);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  } */

  Future<void> signInWithGoogle() async {
    state = AsyncValue.loading();
    try {
      final user = await _authService.signInWithGoogle();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    await _authRepository.logout();
    state = AsyncValue.data(null);
  }
}

// Proveedor de autenticación que utiliza AuthNotifier
final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authService, authRepository);
});

void _showCustomDialog(
    BuildContext context, DialogType type, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(
        dialogType: type,
        title: title,
        content: content,
      );
    },
  );
}
