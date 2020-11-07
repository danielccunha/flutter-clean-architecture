import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:flutter_clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:flutter_clean_architecture/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:flutter_clean_architecture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),
          Align(
            child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return const MessageDisplay(message: 'Start searching!');
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else if (state is Loading) {
                  return const LoadingWidget();
                } else {
                  return TriviaDisplay(numberTrivia: (state as Loaded).trivia);
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const TriviaControls(),
        ],
      ),
    );
  }
}
