package org.bryanfks.sharehop

import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class ShareActivity : FlutterFragmentActivity() {
    override fun getDartEntrypointFunctionName() = "shareMain"

    override fun getBackgroundMode() = BackgroundMode.transparent

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "share_channel",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSharedData" -> result.success(extractFileData(intent))
                "openApp" -> {
                    val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
                    if (launchIntent != null) {
                        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                        startActivity(launchIntent)
                    }
                    finish()
                    result.success(null)
                    overridePendingTransition(0, 0)
                }
                "close" -> {
                    finish()
                    result.success(null)
                    overridePendingTransition(0, 0)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun extractFileData(intent: Intent): Map<String, Any?> {
        val uris = LinkedHashSet<String>()
        when (intent.action) {
            Intent.ACTION_SEND -> {
                (intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
                    ?: intent.getParcelableExtra("android.intent.extra.STREAM"))?.let {
                    uris.add(it.toString())
                }
            }

            Intent.ACTION_SEND_MULTIPLE -> {
                intent.getParcelableArrayListExtra<Uri>(
                    Intent.EXTRA_STREAM,
                )?.forEach {
                    uris.add(it.toString())
                }
            }
        }

        intent.clipData?.let { clipData ->
            for (i in 0 until clipData.itemCount) {
                clipData.getItemAt(i).uri?.let { uris.add(it.toString()) }
            }
        }

        intent.data?.let {
            uris.add(it.toString())
        }

        val filesList = mutableListOf<Map<String, Any?>>()
        var totalBytes = 0L

        for (uriStr in uris) {
            val uri = Uri.parse(uriStr)
            var name: String? = null
            var size: Long? = null
            val mimeType = try {
                contentResolver.getType(uri) ?: intent.type
            } catch (e: Exception) {
                intent.type
            }

            try {
                contentResolver.query(
                    uri,
                    arrayOf(OpenableColumns.DISPLAY_NAME, OpenableColumns.SIZE),
                    null,
                    null,
                    null,
                )?.use { cursor ->
                    if (cursor.moveToFirst()) {
                        val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                        if (nameIndex != -1) {
                            name = cursor.getString(nameIndex)
                        }
                        val sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE)
                        if (sizeIndex != -1) {
                            size = cursor.getLong(sizeIndex)
                        }
                    }
                }
            } catch (e: Exception) {
                // Ignore query errors, fallback below
            }

            if (name.isNullOrBlank()) {
                name = uri.lastPathSegment ?: "File"
            }
            val fileSize = size ?: 0L
            totalBytes += fileSize

            filesList.add(
                mapOf(
                    "uri" to uriStr,
                    "name" to name,
                    "size" to fileSize,
                    "mimeType" to mimeType,
                ),
            )
        }

        return mapOf(
            "uris" to uris.toList(),
            "files" to filesList,
            "totalBytes" to totalBytes,
            "text" to intent.getStringExtra(Intent.EXTRA_TEXT),
        )
    }
}
