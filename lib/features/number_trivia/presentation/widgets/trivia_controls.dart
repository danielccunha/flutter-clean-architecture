import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls();

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: controller,
          onSubmitted: (_) => dispatchConcrete(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  onPressed: dispatchConcrete,
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.primary,
                  child: const Text('Search'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 55,
                child: RaisedButton(
                  onPressed: dispatchRandom,
                  child: const Text('Get random trivia'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchConcrete() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForConcreteNumber(controller.text),
    );
    controller.clear();
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      const GetTriviaForRandomNumber(),
    );
  }
}
