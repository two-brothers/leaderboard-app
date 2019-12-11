package com.twobrothers.leaderboard.scores.add

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.databinding.ActivityAddScoreBinding
import kotlinx.android.synthetic.main.activity_add_score.*

class AddScoreActivity : AppCompatActivity() {

    companion object {

        @JvmStatic
        fun newIntent(launchContext: Context): Intent {
            return Intent(launchContext, AddScoreActivity::class.java)
        }

    }

    private lateinit var viewModel: AddScoreViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_score)

        // Init view model
        viewModel = AddScoreViewModel()

        // Init data binding
        DataBindingUtil.setContentView<ActivityAddScoreBinding>(
            this, R.layout.activity_add_score
        ).apply {
            this.lifecycleOwner = this@AddScoreActivity
            this.viewModel = this@AddScoreActivity.viewModel
        }

        // Init listeners
        button_save.setOnClickListener {
            viewModel.onSaveScore()
        }

    }


}
