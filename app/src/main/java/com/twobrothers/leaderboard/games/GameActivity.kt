package com.twobrothers.leaderboard.games

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.scores.ScoresActivity
import kotlinx.android.synthetic.main.activity_games.*

class GameActivity : AppCompatActivity() {

    companion object {

        private const val EXTRA_SPORT_ID = "GameActivity.Extras.SportId"

        @JvmStatic
        fun newIntent(launchContext: Context, sportId: String): Intent {
            val intent = Intent(launchContext, GameActivity::class.java)
            intent.putExtra(EXTRA_SPORT_ID, sportId)
            return intent
        }

    }

    private lateinit var viewModel: GameViewModel
    private lateinit var gameListAdapter: GameListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_games)

        // Init view model
        val sportId = this.intent.getStringExtra(EXTRA_SPORT_ID) ?: ""
        viewModel = GameViewModel(sportId)

        // Init list adapter
        gameListAdapter = GameListAdapter(object : OnGameClickListener {
            override fun onClick(id: String) {
                viewModel.onGameClick(id)
            }
        })
        recycler_game_list.apply {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = gameListAdapter
        }

        // Init view model observers
        viewModel.games.observe(this, Observer {
            gameListAdapter.submitList(it)
        })

        viewModel.navigateToGame.observe(this, Observer {
            it.getContentIfNotHandled()?.let { gameId ->
                startActivity(ScoresActivity.newIntent(this, gameId))
            }
        })
    }


}
