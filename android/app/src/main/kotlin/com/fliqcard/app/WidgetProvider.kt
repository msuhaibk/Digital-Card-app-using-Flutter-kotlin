package com.fliqcard.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

//import kotlin.random.Random
//
//import java.io.File
//
//import android.graphics.Bitmap;
//import android.graphics.BitmapFactory;
import android.graphics.Color
//import android.widget.ImageView;
//
//
//import kotlinx.android.synthetic.main.*
//
//import  com.fliqcard.app.R
//
//
//import com.bumptech.glide.request.RequestOptions;
//import com.bumptech.glide.request.target.Target;
//import com.bumptech.glide.util.Preconditions;
//
//import com.squareup.picasso.Picasso
//
//import android.util.Base64

import org.json.JSONException
import org.json.JSONObject

//import android.util.Log;
//import android.util.TypedValue
import android.view.View
//import android.widget.FrameLayout


class AppWidgetProvider : HomeWidgetProvider() {

        var title = "your title";
        var subtitle = "your subtitle";
        var company = "your company name";
        var email = "your email id";
        var bgcolor = "";
        var cardcolor = "";
        var fontcolor = "";

        override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
            appWidgetIds.forEach { widgetId ->
                val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {


                    // Open App on Widget Click
                     val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                             MainActivity::class.java)
                     setOnClickPendingIntent(R.id.widget_root, pendingIntent)



                    val vcarddata = widgetData.getString("_vcardata", "")
                    var isactivated = widgetData.getInt("_isActivated", 0)

//                    profileImagePath
//                      logoImagePath
//
                    try {

                        var obj =  JSONObject(vcarddata)
                        title = obj.getString("title")
                        subtitle = obj.getString("subtitle")
                        company = obj.getString("company")
                        email = obj.getString("email")
                        bgcolor = obj.getString("bgcolor")
                        cardcolor = obj.getString("cardcolor")
                        fontcolor = obj.getString("fontcolor")
//                        Log.d("mycheckdeb", title)
//
                    } catch (e: JSONException) {
                        e.printStackTrace()
                    }

//                  Setting card theme based on values
                    if(bgcolor.isNotEmpty()) {
                        setInt(R.id.background, "setBackgroundColor", Color.parseColor(bgcolor))
                    }
                    if(cardcolor.isNotEmpty())
                    {
                        setInt(R.id.title, "setBackgroundColor", Color.parseColor(cardcolor))
                        setInt(R.id.subtitle, "setBackgroundColor", Color.parseColor(cardcolor))
                    }
                    if(fontcolor.isNotEmpty()){
                        setTextColor(R.id.title,Color.parseColor(fontcolor))
                    }
                    if(isactivated == 1){
                        setInt(R.id.activate, "setVisibility", View.GONE)
                    }

//                    setting card texts
                    setTextViewText(R.id.title, title)
                    setTextViewText(R.id.subtitle, subtitle)
                    setTextViewText(R.id.company, company)
                    setTextViewText(R.id.email, email)


                    // Pending intent to update counter on button click
//                    val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
//                            Uri.parse("myAppWidget://updatecounter"))
//                    setOnClickPendingIntent(R.id.bt_update, pendingIntent)
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }