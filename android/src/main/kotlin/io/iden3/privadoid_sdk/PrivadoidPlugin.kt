package io.iden3.privadoid_sdk

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PrivadoidPlugin */
class PrivadoidPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "privadoid_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    //var channel : MethodChannel? = null
    var _registrar : Registrar? = null
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      _registrar = registrar
      val channel = MethodChannel(registrar.messenger(), "privadoid_sdk")
      channel.setMethodCallHandler(CorelibPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        handler.post { result.success("Android ${android.os.Build.VERSION.RELEASE}") }
      }
      "newIdentity" -> {
        if (!call.hasArgument("alias") || !call.hasArgument("pass")) {
          handler.post { result.error("newIdentity",
                  "Send argument as Map. Mandatory arguments: alias (string), pass (string).",
                  null) }
          return
        }
        val alias = call.argument<String>("alias")
        val pass = call.argument<String>("pass")
        val path: String? = call.argument<String>("path")
        val sharedPath: String? = call.argument<String>("shared")
        thread(start = true) {
          try {
            val fullPath: String = "$path/$alias/"
            val fileOrDirectory = File(fullPath)
            if (fileOrDirectory.exists()) {
              Helpers.deleteRecursive(fullPath)
            }
            val created = Helpers.mkdir(fullPath)
            if (created) {
              identity = Identity(fullPath, sharedPath, pass, web3Url, checkTicketsPeriod, null, object : Sender {
                override fun send(event: Event) {
                  print(event)
                }
              })
              handler.post { result.success(true) }
            } else {
              handler.post { result.success(false) }
            }
          } catch (e: Exception) {
            handler.post { result.error("newIdentity", e.message, null) }
          }
        }
      }
      "loadIdentity" -> {
        if (!call.hasArgument("alias") || !call.hasArgument("pass")) {
          handler.post { result.error("loadIdentity",
                  "Send argument as Map. Mandatory arguments: alias (string), pass (string).",
                  null) }
          return
        }
        val alias = call.argument<String>("alias")
        val pass = call.argument<String>("pass")
        val path: String? = call.argument<String>("path")
        val sharedPath: String? = call.argument<String>("shared")
        thread(start = true) {
          try {
            val fullPath: String = "$path/$alias"
            identity = Identity(fullPath, sharedPath, pass, web3Url, checkTicketsPeriod, object:Sender {
              override fun send(event: Event) {
                print(event)
              }
            })
            handler.post { result.success(true) }
          } catch (e: Exception) {
            handler.post { result.error("loadIdentity", e.message, null) }
          }
        }
      }
      "deleteIdentity" -> {
        val path: String? = call.argument<String>("path")
        try {
          Helpers.deleteRecursive(path + "/" + call.argument("alias"))
        } catch (e: Exception) {
          handler.post { result.error("deleteIdentity", e.message, null) }
        }
      }
      "stopIdentity" -> {
        identity?.stop()
        handler.post { result.success(true) }
      }
      "requestClaim" -> {
        if (!call.hasArgument("issuer") || !call.hasArgument("formData")) {
          handler.post { result.error("requestClaim", "Send argument as Map. Mandatory arguments: issuer (string), formData (string)", null) }
          return
        }
        val issuer = call.argument<String>("issuer")
        val formData = call.argument<String>("formData")
        identity?.requestClaimWithCb(issuer, formData, object:CallbackRequestClaim {

          override fun fn(ticket: Ticket?, exception: Exception?) {
            if (exception != null) {
              handler.post { result.error("requestClaim", exception.message, null) }
            } else {
              if (ticket != null) {
                handler.post { result.success(Helpers.ticketToMap(ticket)) }
              } else {
                handler.post { result.error("requestClaim", "Error requesting claim: No ticket found", null) }
              }
            }
          }
        })
      }
      "proveClaim" -> {
        if (!call.hasArgument("verifier") || !call.hasArgument("claimDBKey")) {
          handler.post { result.error("proveClaim", "Send argument as Map. Mandatory arguments: verifier (String), claimDBKey (String)", null) }
          return
        }
        val verifier = call.argument<String>("verifier")
        val claimDBKey = call.argument<String>("claimDBKey")
        identity?.proveClaimWithCb(verifier, claimDBKey, object:CallbackProveClaim {

          override fun fn(success: Boolean, exception: Exception?) {
            if (exception != null) {
              handler.post { result.error("proveClaim", exception.message, null) }
            } else {
              if (success) {
                handler.post { result.success(success) }
              } else {
                handler.post { result.error("proveClaim", "Error proving claim", null) }
              }
            }
          }
        })
      }
      "listClaims" -> {
        val claims = ArrayList<HashMap<*,*>>()
        try {
          val cdb = identity?.getClaimDB()
          cdb?.iterateClaimsJSON( object:ClaimDBIterFner {

            @Throws(Exception::class)
            override fun fn(key: String?, claim: String?): Boolean {
              val cMap = HashMap<String,Any?>()
              cMap["DBKey"] = key
              cMap["claim"] = claim
              claims.add(cMap)
              return true
            }
          })
          handler.post {result.success(claims) }
          return
        } catch (e: Exception) {
          handler.post { result.error("listClaims", e.message, null) }
        }
      }
      "listCreds" -> {
        val claims = ArrayList<HashMap<*,*>>()
        try {
          val cdb = identity?.getClaimDB()
          cdb?.iterateCredExistJSON( object:ClaimDBIterFner {

            @Throws(Exception::class)
            override fun fn(key: String?, claim: String?): Boolean {
              val cMap = HashMap<String,Any?>()
              cMap["DBKey"] = key
              cMap["claim"] = claim
              claims.add(cMap)
              return true
            }
          })
          handler.post { result.success(claims) }
          return
        } catch (e: Exception) {
          handler.post { result.error("listCreds", e.message, null) }
        }
      } /* else if (call.method == "listTickets") {
  val parsedTickets = ArrayList<HashMap<*,*>>()
  try {
    val tickets = identity!!.getTickets()
    tickets.iterate( object:TicketOperator {

      @Throws(Exception::class)
      override fun iterate(ticket: Ticket?): Boolean {
        parsedTickets.add(Helpers.ticketToMap(ticket!!))
        return true
      }
    });
    handler.post { result.success(parsedTickets) }
    return
  } catch (e: Exception) {
    handler.post { result.error("listTickets", e.message, null) }
  }
}*/
      else -> {
        result.notImplemented()
      }
    }
  }

  class SimpleRunnable(_handler: Handler, flutterEngine: FlutterEngine?, registrar: Registrar?, alias: String,
                       _identity: Identity): Runnable {

    var identity: Identity = _identity
    var handler: Handler = _handler
    private lateinit var channel: MethodChannel
    var shouldStop : Boolean = false

    init {
      when {
        flutterEngine != null -> {
          channel =  MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "iden3/events/$alias")
        }
        registrar != null -> {
          channel = MethodChannel(registrar.messenger(), "iden3/events/$alias")
        }
        else -> {
          Log.i("SimpleRunnable", "not working!!")
        }
      }
    }

    fun stop() {
      shouldStop = true
    }

    override fun run() {
      if (!shouldStop) {
        try {
          //val event = identity!!.getNextEvent()
          //println("Event: " + event.toString())
          //send(event)
        } catch (e: Exception) {
          println("Error getting next event: " + e.message)
        }
        handler.postDelayed(this, 1000)
      }
    }

    private fun send(event: Event) {
      if (event != null) {
        println("EVENT: " + event.toString())
        val flutterEvent: HashMap<String, Any?> = HashMap<String, Any?>()
        flutterEvent["ticketId"] = event.getTicketId()
        if (event.getErr() != null) {
          flutterEvent["error"] = event.getErr()
        } else flutterEvent["dataJson"] = event.getData()
        handler.post { channel.invokeMethod(event.getType(), flutterEvent) }
      } else {
        println("Event is null")
      }
    }
  }
}
