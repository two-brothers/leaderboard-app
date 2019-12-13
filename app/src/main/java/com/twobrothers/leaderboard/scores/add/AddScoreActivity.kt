package com.twobrothers.leaderboard.scores.add

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.RadioButton
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.databinding.ActivityAddScoreBinding
import kotlinx.android.synthetic.main.activity_add_score.*

class AddScoreActivity : AppCompatActivity() {

    companion object {

        private const val EXTRA_GAME_ID = "AddScoreActivity.Extras.GameId"

        @JvmStatic
        fun newIntent(launchContext: Context, gameId: String): Intent {
            val intent = Intent(launchContext, AddScoreActivity::class.java)
            intent.putExtra(EXTRA_GAME_ID, gameId)
            return intent
        }

    }

    private lateinit var viewModel: AddScoreViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_score)

        // Init view model
        val gameId = this.intent.getStringExtra(EXTRA_GAME_ID) ?: ""
        viewModel = AddScoreViewModel(gameId)

        // Init data binding
        DataBindingUtil.setContentView<ActivityAddScoreBinding>(
            this, R.layout.activity_add_score
        ).apply {
            this.lifecycleOwner = this@AddScoreActivity
            this.viewModel = this@AddScoreActivity.viewModel
        }

        // Init observers
        viewModel.players.observe(this, Observer {
            group_players.removeAllViews()
            it.forEachIndexed { index, player ->
                val view = RadioButton(baseContext)
                view.text = player.name
                view.id = index + 1
                group_players.addView(view)
            }

        })

        // Init listeners
        button_save.setOnClickListener {
            viewModel.onSaveScore()
        }

    }


}
