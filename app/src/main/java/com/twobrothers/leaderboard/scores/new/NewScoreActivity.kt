package com.twobrothers.leaderboard.scores.new

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.twobrothers.leaderboard.R

class NewScoreActivity : AppCompatActivity() {

    companion object {

        @JvmStatic
        fun newIntent(launchContext: Context): Intent {
            return Intent(launchContext, NewScoreActivity::class.java)
        }

    }

    //  private lateinit var viewModel: NewScoresViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_new_score)

        // Init view model
        // viewModel = NewScoresViewModel()

        // Init view model observers
    }


}
