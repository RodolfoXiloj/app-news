import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> register(String email, String password) async {
    state = AsyncValue.loading();
    try {
      //await _authRepository.register(email, password);
      final user = await _authService.registerWithEmail(email, password);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = AsyncValue.loading();
    try {
      //await _authRepository.login(email, password);
      final user = await _authService.signInWithEmail(email, password);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

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
