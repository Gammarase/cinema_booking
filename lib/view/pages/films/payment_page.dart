import 'package:cinema_booking/domain/entities/films_session.dart';
import 'package:cinema_booking/domain/entities/payment_card_data.dart';
import 'package:cinema_booking/helper/regexs.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/themes/ui_components/app/alert_dialog.dart';
import 'package:cinema_booking/view/themes/ui_components/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.session, required this.filmName})
      : super(key: key);
  final FilmSession session;
  final String filmName;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController _emailController;
  late TextEditingController _cardNumController;
  late TextEditingController _cvvController;
  late TextEditingController _expDateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _cardNumController = TextEditingController();
    _cvvController = TextEditingController();
    _expDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cardNumController.dispose();
    _cvvController.dispose();
    _expDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        "Payment",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.arrow_back)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.filmName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('in ${widget.session.type} at ${widget.session.stringDate}'),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AppAuthBloc, AppState>(
                builder: (context, state) {
                  return Text(
                    "Summary price: \$${state.reservedSeats.fold(0, (int previousValue, element) => previousValue += element.price).toString()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Number',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                          return RegExs.card.hasMatch(value ?? '')
                              ? null
                              : 'Input valid card number';
                        },
                        controller: _cardNumController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        inputFormatters: [
                          CardFormatter(
                            allowedSymbols: RegExs.onlyDigits,
                            sample: "xxxx xxxx xxxx xxxx",
                            separator: " ",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Valid Until',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    return RegExs.cardExpirationDate
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Input valid date';
                                  },
                                  controller: _expDateController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  inputFormatters: [
                                    CardFormatter(
                                      allowedSymbols: RegExs.onlyDigits,
                                      sample: "xx/xx",
                                      separator: "/",
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVV',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    return RegExs.cvv.hasMatch(value ?? '')
                                        ? null
                                        : 'Input valid CVV';
                                  },
                                  controller: _cvvController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExs.onlyDigits),
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'E-mail',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextFormField(
                        validator: (value) {
                          return RegExs.email.hasMatch(value ?? '')
                              ? null
                              : 'Input valid E-mail';
                        },
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomAppButton(
                            action: _payment,
                            child: Text(
                              'Confirm Payment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.apply(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _payment() {
    if (_formKey.currentState!.validate()) {
      var localState = context.read<AppAuthBloc>().state;
      localState.dioClient
          .buyTickets(
            localState.reservedSeats.map<int>((e) => e.id).toList(),
            widget.session.id,
            PayCardData(
                cardNumber: _cardNumController.text.replaceAll(' ', ''),
                cvvCode: _cvvController.text,
                expDate: _expDateController.text,
                holderEmail: _emailController.text),
          )
          .then(
            (value) => showMessage(
                'You bought tickets',
                [
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                    child: const Text('Back to main'),
                  )
                ],
                context,
                'Congratulation!'),
          )
          .onError(
            (error, stackTrace) => showMessage(
                error.toString(),
                [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  )
                ],
                context,
                'Error'),
          );
    }
  }
}

class CardFormatter extends TextInputFormatter {
  final String sample;
  final String separator;
  final RegExp allowedSymbols;

  CardFormatter({
    required this.sample,
    required this.separator,
    required this.allowedSymbols,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty &&
        newValue.text.length > oldValue.text.length) {
      if (newValue.text.length > sample.length ||
          !allowedSymbols
              .hasMatch(newValue.text.substring(newValue.text.length - 1))) {
        return oldValue;
      }
      if (newValue.text.length < sample.length &&
          sample[newValue.text.length - 1] == separator) {
        return TextEditingValue(
          text:
              '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      }
    }
    return newValue;
  }
}
