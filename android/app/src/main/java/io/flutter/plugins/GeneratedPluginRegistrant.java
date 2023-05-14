package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.tahamalas.internet_speed_test.InternetSpeedTestPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    InternetSpeedTestPlugin.registerWith(registry.registrarFor("com.tahamalas.internet_speed_test.InternetSpeedTestPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
