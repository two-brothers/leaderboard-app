package com.twobrothers.leaderboard.sports

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import com.twobrothers.leaderboard.R
import kotlinx.android.synthetic.main.activity_sports.*

class SportsActivity : AppCompatActivity() {

    private val viewModel: SportsViewModel = SportsViewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sports)

        viewModel.sports.observe(this, Observer {
            // TODO: show list of sports
        })
    }


}
