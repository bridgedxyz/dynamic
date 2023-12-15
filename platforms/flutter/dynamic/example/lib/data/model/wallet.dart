import 'package:dynamic/dynamic.dart';

class WalletLayout extends XLayout<WalletBody> {
  WalletLayout(this.body) : super(body: body);
  WalletBody body;
}

class WalletBody {
  WalletBody(this.title, this.desc, this.background, this.asset, this.action);

  XText title;
  XText desc;
  XImage background;
  XImage asset;
  XButton action;
}
