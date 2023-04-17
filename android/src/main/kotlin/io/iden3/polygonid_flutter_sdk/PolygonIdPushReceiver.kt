class PolygonIdPushReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        /// We are passing all data to the Flutter side, so we can handle it there
        intent.extras
    }
}