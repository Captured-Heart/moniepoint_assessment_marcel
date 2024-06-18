import 'package:flutter/material.dart';

import '../../app.dart';

class BottomSheetImageWidget extends StatelessWidget {
  const BottomSheetImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeWidth(1),
      padding: const EdgeInsets.all(6),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const ImgWidget(
            text: 'Gladkova St., 25',
          ),
          SizedBox(
            height: context.sizeHeight(0.4),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ImgWidget(
                      imgPath: ImagesPaths.furniture3,
                      imgHeight: context.sizeHeight(0.5),
                      milliseconds: 3600,
                      text: 'Malaga St., 92',
                      sliderWidth: 0.36,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: ImgWidget(
                            imgPath: index.isEven ? ImagesPaths.furniture1 : ImagesPaths.furniture2,
                            imgHeight: context.sizeHeight(0.4),
                            milliseconds: 3650,
                            text: index == 0 ? 'Margaret., 32' : 'Trefeleva., 43',
                            sliderWidth: 0.36,
                          ),
                        ),
                      ).columnInPadding(5),
                    ),
                  )
                ].rowInPadding(5)),
          ).padSymmetric(vertical: 5),
        ],
      ),
    );
  }
}
