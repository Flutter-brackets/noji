import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';

class PoweredByHout extends StatelessWidget {
  const PoweredByHout({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppConstants.poweredByHout,
      child: IgnorePointer(
        child: SelectionContainer.disabled(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              AppConstants.poweredByHout,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.4,
                color: Color(0xFFA89A8C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
