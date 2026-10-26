
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportState {
  form,
  loading,
  success,
  empty,
  error,
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() =>
      _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  ReportState _state = ReportState.form;
  String _demoResponse = 'Success';
  String _submittedTitle = '';
  String _submittedDescription = '';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _state = ReportState.loading;
      _submittedTitle = _titleController.text.trim();
      _submittedDescription =
          _descriptionController.text.trim();
    });

    // Simulated network request for Activity 9.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      switch (_demoResponse) {
        case 'Success':
          _state = ReportState.success;
          break;
        case 'Empty':
          _state = ReportState.empty;
          break;
        case 'Error':
          _state = ReportState.error;
          break;
        default:
          _state = ReportState.success;
      }
    });
  }

  Future<void> _retry() async {
    if (_demoResponse == 'Success') {
      setState(() {
        _state = ReportState.form;
      });
      await _submitReport();
      return;
    }

    await _submitReport();
  }

  void _createAnotherReport() {
    _titleController.clear();
    _descriptionController.clear();

    setState(() {
      _state = ReportState.form;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.account_balance, size: 20),
            SizedBox(width: 10),
            Text('LCO Home', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case ReportState.loading:
        return _buildLoadingState();

      case ReportState.success:
        return _buildSuccessState();

      case ReportState.empty:
        return _buildEmptyState();

      case ReportState.error:
        return _buildErrorState();

      case ReportState.form:
        return _buildForm();
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.description_outlined,
              color: Color(0xFF119E94),
              size: 38,
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Create Report',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF193F58),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              'Enter the details of your report below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Report Title',
            controller: _titleController,
            prefixIcon: const Icon(Icons.title),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a report title';
              }
              if (value.trim().length < 3) {
                return 'Title must have at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Report Description',
            controller: _descriptionController,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            prefixIcon: const Icon(Icons.notes),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description';
              }
              if (value.trim().length < 10) {
                return 'Description must have at least 10 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Demo response (for testing)',
            style: TextStyle(
              color: Color(0xFF193F58),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
          initialValue: _demoResponse,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            items: const [
              DropdownMenuItem(
                value: 'Success',
                child: Text('Success'),
              ),
              DropdownMenuItem(
                value: 'Empty',
                child: Text('Empty'),
              ),
              DropdownMenuItem(
                value: 'Error',
                child: Text('Error'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _demoResponse = value;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Submit Report',
            icon: const Icon(Icons.send),
            onPressed: _submitReport,
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'Back to Home',
            outlined: true,
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Note: Responses are simulated for this lab activity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Color(0xFF119E94),
        ),
        SizedBox(height: 20),
        Text(
          'Submitting Report...',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF193F58),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Please wait while we process your report.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          '(Simulated loading state)',
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      children: [
        const Icon(
          Icons.check_circle,
          size: 64,
          color: Color(0xFF119E94),
        ),
        const SizedBox(height: 16),
        const Text(
          'Report Submitted!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF193F58),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your report was submitted successfully in this demo.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _reportDetails(),
        const SizedBox(height: 20),
        AppButton(
          text: 'Create Another Report',
          onPressed: _createAnotherReport,
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'Back to Home',
          outlined: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const Icon(
          Icons.inbox_outlined,
          size: 64,
          color: Color(0xFF119E94),
        ),
        const SizedBox(height: 16),
        const Text(
          'No Reports Found',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF193F58),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'There are no report records to display for this simulated response.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Retry',
          icon: const Icon(Icons.refresh),
          onPressed: _retry,
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'Back to Form',
          outlined: true,
          onPressed: () {
            setState(() {
              _state = ReportState.form;
            });
          },
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      children: [
        const Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.redAccent,
        ),
        const SizedBox(height: 16),
        const Text(
          'Something Went Wrong',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF193F58),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'We could not complete the simulated request. Please try again.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Retry',
          icon: const Icon(Icons.refresh),
          onPressed: _retry,
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'Back to Form',
          outlined: true,
          onPressed: () {
            setState(() {
              _state = ReportState.form;
            });
          },
        ),
      ],
    );
  }

  Widget _reportDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Report Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF193F58),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Title: $_submittedTitle',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text('Description: $_submittedDescription'),
          const SizedBox(height: 12),
          const Text(
            'Demo only — this report was not saved to a database.',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
