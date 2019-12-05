package com.twobrothers.leaderboard.scores

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.twobrothers.leaderboard.R
import kotlinx.android.synthetic.main.activity_scores.*

class ScoresActivity : AppCompatActivity() {

    companion object {

        private const val EXTRA_GAME_ID = "ScoresActivity.Extras.GameId"

        @JvmStatic
        fun newIntent(launchContext: Context, gameId: String): Intent {
            val intent = Intent(launchContext, ScoresActivity::class.java)
            intent.putExtra(EXTRA_GAME_ID, gameId)
            return intent
        }

    }

    private lateinit var viewModel: ScoresViewModel
    // private lateinit var scoresListAdapter: ScoresListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sports)

        // Init view model
        val gameId = this.intent.getStringExtra(EXTRA_GAME_ID) ?: ""
        viewModel = ScoresViewModel(gameId)

        // Init list adapter
        /* recycler_score_list.apply {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = scoresListAdapter
        }*/

        // Init view model observers
        /* viewModel.scores.observe(this, Observer {
            scoresListAdapter.submitList(it)
        })*/
    }


}
