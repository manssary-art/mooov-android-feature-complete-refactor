import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/_order_rating_providers.dart';
import 'widgets/order_rating_stars.dart';

class OrderRatingScreen extends HookConsumerWidget {
  final String orderId;
  final VoidCallback onNavBack;

  const OrderRatingScreen({
    super.key,
    required this.orderId,
    required this.onNavBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        orderRatingProvider.overrideWith(() => OrderRatingNotifier(orderId)),
      ],
      child: _OrderRatingScreen(
        orderId: orderId,
        onNavBack: onNavBack,
      ),
    );
  }
}

class _OrderRatingScreen extends HookConsumerWidget {
  final String orderId;
  final VoidCallback onNavBack;

  const _OrderRatingScreen({
    required this.orderId,
    required this.onNavBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(orderRatingProvider);
    final sideEffect = ref.watch(sideEffectProvider);
    final action = ref.watch(orderRatingActionProvider);

    final isSubmitting = useState(false);

    useEffect(
      () => sideEffect.stream.listen((effect) {
        switch (effect) {
          case OrderRatingSideEffect$NavBack():
            onNavBack();
            break;
          case OrderRatingSideEffect$ShowError():
            isSubmitting.value = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not submit your rating. Please try again.'),
              ),
            );
            break;
        }
      }).cancel,
      [sideEffect],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onNavBack,
        ),
      ),
      body: SafeArea(
        child: data.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Something went wrong: $error'),
          ),
          data: (value) => _RatingForm(
            orderId: orderId,
            workerName: [value.order.worker?.firstName, value.order.worker?.lastName]
                .where((e) => e != null && e.isNotEmpty)
                .join(' '),
            workerImageUrl: value.order.worker?.image,
            workerId: value.order.worker?.userId,
            availableTags: value.tags,
            isSubmitting: isSubmitting,
            onSubmit: (workerId) async {
              isSubmitting.value = true;
              await action.onSubmitClicked(orderId: orderId, workerId: workerId);
            },
          ),
        ),
      ),
    );
  }
}

class _RatingForm extends HookConsumerWidget {
  final String orderId;
  final String workerName;
  final String? workerImageUrl;
  final String? workerId;
  final Map<String, String> availableTags;
  final ValueNotifier<bool> isSubmitting;
  final Future<void> Function(String workerId) onSubmit;

  const _RatingForm({
    required this.orderId,
    required this.workerName,
    required this.workerImageUrl,
    required this.workerId,
    required this.availableTags,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(ratingProvider);
    final description = ref.watch(descriptionProvider);
    final selectedTags = ref.watch(selectedTagsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildWorkerProfile(context),
        const Divider(height: 32),
        _buildRatingSection(context, ref, rating),
        const Divider(height: 32),
        _buildTagsSection(context, ref, selectedTags),
        const Divider(height: 32),
        _buildDescriptionSection(context, ref, description),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isSubmitting.value || workerId == null
                ? null
                : () => onSubmit(workerId!),
            child: isSubmitting.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkerProfile(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: workerImageUrl != null ? NetworkImage(workerImageUrl!) : null,
          child: workerImageUrl == null ? const Icon(Icons.person, size: 32) : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            workerName.isNotEmpty ? workerName : 'Worker',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, WidgetRef ref, int rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rating', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        OrderRatingStars(
          rating: rating,
          onChanged: (value) => ref.read(ratingProvider.notifier).state = value,
        ),
      ],
    );
  }

  Widget _buildTagsSection(BuildContext context, WidgetRef ref, List<String> selectedTags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Impression', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableTags.entries.map((entry) {
            final isSelected = selectedTags.contains(entry.key);
            return FilterChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (selected) {
                final current = List<String>.from(selectedTags);
                if (selected) {
                  current.add(entry.key);
                } else {
                  current.remove(entry.key);
                }
                ref.read(selectedTagsProvider.notifier).state = current;
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context, WidgetRef ref, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextField(
          maxLines: null,
          minLines: 4,
          textCapitalization: TextCapitalization.sentences,
          controller: TextEditingController(text: description)
            ..selection = TextSelection.collapsed(offset: description.length),
          onChanged: (value) => ref.read(descriptionProvider.notifier).state = value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Add a comment (optional)',
          ),
        ),
      ],
    );
  }
}
