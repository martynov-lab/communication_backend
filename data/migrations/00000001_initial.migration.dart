import 'dart:async';

import 'package:conduit/conduit.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {}

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
