package com.example.dev_menu;

import android.content.Context;
import androidx.annotation.NonNull;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.BinaryMessenger;

class DevMenu {
  private PackageManager packageManager;

  DevMenu(PackageManager packageManager) {
    this.packageManager = packageManager;
  }

  protected PackageManager getPackageManager() {
    return packageManager;
  }
}

public class DevMenuPlugin implements FlutterPlugin {
  static final String PACKAGE_CHANNEL = "devmenu.flutter.io/packageInfo";
  private MethodChannel methodChannel;

  public static void registerWith(Registrar registrar) {
    DevMenuPlugin plugin = new DevMenuPlugin();
    plugin.setupChannels(registrar.messenger(), registrar.context());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    setupChannels(binding.getFlutterEngine().getDartExecutor(), binding.getApplicationContext());
  }

  private void setupChannels(BinaryMessenger messenger, Context context) {
    methodChannel = new MethodChannel(messenger, PACKAGE_CHANNEL);
    PackageManager packageManager = context.getPackageManager();
    DevMenu devMenu = new DevMenu(packageManager);

    DevMenuMethodChannelHandler methodChannelHandler = new DevMenuMethodChannelHandler(devMenu);

    methodChannel.setMethodCallHandler(methodChannelHandler);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}