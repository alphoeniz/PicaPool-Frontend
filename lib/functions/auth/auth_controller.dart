import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:picapool/functions/auth/auth_api.dart';
import 'package:picapool/functions/storage/storage_controller.dart';
import 'package:picapool/models/auth_model.dart';
import 'package:picapool/models/user_model.dart';
import 'package:picapool/screens/otp_screen.dart';
import 'package:picapool/screens/personal_details.dart';
import 'package:picapool/widgets/bottom_navbar/common_bottom_navbar.dart';
import 'package:http/http.dart' as http;

// AuthController provider using Riverpod's StateNotifier
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final storageController = ref.read(storageProvider.notifier);
  return AuthController(storageController: storageController);
});

// Auth state class
class AuthState {
  final Auth? auth;
  final User? user;
  final bool isLoading;
  final String errorMessage;

  AuthState({
    this.auth,
    this.user,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AuthState copyWith({
    Auth? auth,
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      auth: auth ?? this.auth,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// AuthController class using StateNotifier
class AuthController extends StateNotifier<AuthState> {
  final AuthApi _authApi = AuthApi();
  final StorageController _storageController;

  AuthController({required StorageController storageController})
      : _storageController = storageController,
        super(AuthState()) {
    _loadUserOnStartup();
  }

  /// Load user and auth data from storage at startup.
  Future<void> _loadUserOnStartup() async {
    await _storageController.loadAuth();
    await _storageController.loadUser();

    final storageState = _storageController.state;
    state = state.copyWith(
      auth: storageState.auth,
      user: storageState.user,
    );
  }

  /// Handle Google login and store auth and user data.
  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final result = await _authApi.signInWithGoogle();

    result.fold(
      (fail) {
        state = state.copyWith(
          errorMessage: fail.message,
          auth: null,
          user: null,
        );
        showErrorDialog(fail.message);
      },
      (authData) async {
        await _storageController.saveAuth(authData);
        state = state.copyWith(
          auth: authData,
          user: authData.user,
          errorMessage: '',
        );
        checkForExistingUser();
      },
    );
    state = state.copyWith(isLoading: false);
  }

  /// Handle Apple login and store auth and user data.
  Future<void> loginWithApple() async {
    state = state.copyWith(isLoading: true);
    final result = await _authApi.signInWithApple();

    result.fold(
      (fail) {
        state = state.copyWith(
          errorMessage: fail.message,
          auth: null,
          user: null,
        );
        showErrorDialog(fail.message);
      },
      (authData) async {
        await _storageController.saveAuth(authData);
        state = state.copyWith(
          auth: authData,
          user: authData.user,
          errorMessage: '',
        );
        checkForExistingUser();
      },
    );
    state = state.copyWith(isLoading: false);
  }

  Future<void> sendOtp(String phoneNumber) async {
    final String url = 'https://api.picapool.com/v2/otp?mobile=$phoneNumber';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '{}', // Sending an empty JSON object as the body
      );

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      if (response.statusCode == 201) {
        Get.to(() => OtpScreen(phoneNumber: phoneNumber));
      } else {
        if (mounted) {
          (
            const SnackBar(
                content: Text('Failed to send OTP. Please try again.')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      showErrorDialog("An error occurred. Please try again later.");
    }
  }

  /// Updates the user data and stores it.
  Future<void> updateUser(Map<String, dynamic> updateValues) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await _authApi.updateUser(
        updateValues,
        state.auth!.accessToken!,
        id: state.user!.id,
      );

      result.fold(
        (fail) {
          state = state.copyWith(errorMessage: fail.message);
          showErrorDialog(fail.message);
        },
        (updatedUser) async {
          state.user!.update(updateValues);
          await _storageController.saveUser(state.user!);
          state = state.copyWith(user: state.user, errorMessage: '');
        },
      );
    } catch (e) {
      debugPrint('Update User Error: $e');
      showErrorDialog('Failed to update user. Please try again.');
    }

    state = state.copyWith(isLoading: false);
  }

  /// Logs out the user and clears the stored auth and user data.
  Future<void> logout() async {
    await _storageController.clearUser();
    await _storageController.clearAuth();
    state = state.copyWith(auth: null, user: null);
  }

  /// Check if a user is logged in and navigate accordingly.
  void checkForExistingUser() {
    if (state.auth == null) {
      return;
    } else if (state.user == null || state.user!.name == null) {
      Get.to(() => const PersonalDetails());
    } else {
      Get.offAll(() => const NewBottomBar());
    }
  }

  /// Show error dialog for failed operations.
  void showErrorDialog(String errorMessage) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
