package com.example.dev_menu;

import android.content.pm.PackageInfo;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.HashMap;
import java.util.Map;

class DevMenuMethodChannelHandler implements MethodChannel.MethodCallHandler {

  private DevMenu devMenu;

  DevMenuMethodChannelHandler(DevMenu devMenu) {
    assert (devMenu != null);
    this.devMenu = devMenu;
  }

  @Override
  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
    if (call.method.equals("getPackageInfo")) {
      String packageName = call.argument("packageName");
      try {
        PackageInfo info = devMenu.getPackageManager().getPackageInfo(packageName, 0);

        Map<String, String> map = new HashMap<>();
        map.put("appName", info.applicationInfo.loadLabel(devMenu.getPackageManager()).toString());
        map.put("packageName", info.packageName);
        map.put("version", info.versionName);

        result.success(map);
      }
      catch (Exception error) {
        result.error("ERROR", error.toString(), error);
    }
    } else {
      result.notImplemented();
    }
  }
}
