package io.iden3.privadoid_sdk

import android.util.Log
//import iden3mobile.Ticket
import java.io.File
import java.util.HashMap

object Helpers {
    /*fun ticketToMap(ticket: Ticket): HashMap<String, String> {
        val tMap: HashMap<String, String> = HashMap<String, String>()
        tMap["id"] = ticket.getId()
        tMap["lastChecked"] = ticket.getLastChecked().toString()
        tMap["type"] = ticket.getType()
        return tMap
    }

    fun mkdir(path: String) : Boolean {
        val fileOrDirectory = File(path)
        return if (!fileOrDirectory.exists()) {
            Log.println(Log.INFO, "makeDir",
                    "creating file/dir " + fileOrDirectory.path)
            fileOrDirectory.mkdir()
        } else {
            Log.println(Log.INFO, "makeDir",
                    "file/dir already exists " + fileOrDirectory.path)
            false
        }
    }

    fun deleteRecursive(path: String) {
        val fileOrDirectory = File(path)
        try {
            fileOrDirectory.deleteRecursively()
            Log.println(Log.INFO, "deleteRecursive",
                    "deleting file/dir " + fileOrDirectory.path)
        } catch (e: Exception) {
            Log.println(Log.ERROR, "deleteRecursive",
                    "deleting file/dir " + fileOrDirectory.path + ". ERROR: " + e.message)
            //TODO: handle exception
        }
    }*/
}