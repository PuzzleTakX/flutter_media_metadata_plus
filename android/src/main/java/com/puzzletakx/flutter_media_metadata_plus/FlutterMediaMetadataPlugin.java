package com.puzzletakx.flutter_media_metadata_plus;

import java.io.IOException;
import java.util.HashMap;
import java.lang.Runnable;
import java9.util.concurrent.CompletableFuture;

import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class FlutterMediaMetadataPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel =
        new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_media_metadata_plus");
    channel.setMethodCallHandler(this);
  }

  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
    if (call.method.equals("MetadataRetriever")) {
      final String filePath = (String) call.argument("filePath");
      CompletableFuture.runAsync(new Runnable() {
        @Override
        public void run() {
          final MetadataRetriever retriever = new MetadataRetriever();
          try {
            retriever.setFilePath(filePath);
            final HashMap<String, Object> response = new HashMap<String, Object>();
            response.put("metadata", retriever.getMetadata());
            response.put("albumArt", retriever.getAlbumArt());
            new Handler(Looper.getMainLooper())
                .post(new Runnable() {
                  @Override
                  public void run() {
                    result.success(response);
                  }
                });
          } catch (final Exception e) {
            new Handler(Looper.getMainLooper())
                .post(new Runnable() {
                  @Override
                  public void run() {
                    result.error("MetadataRetrieverError", e.getMessage(), null);
                  }
                });
          } finally {
            try {
              retriever.release();
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
