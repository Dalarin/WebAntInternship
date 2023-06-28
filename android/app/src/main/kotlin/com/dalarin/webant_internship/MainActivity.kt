package com.dalarin.webant_internship

import android.os.Bundle
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.distribute.Distribute
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        AppCenter.start(application, "b5315862-6d2b-4311-98f2-1d92f6a532cd", Distribute::class.java)

        super.onCreate(savedInstanceState)
    }


}
