package com.twobrothers.leaderboard.scores

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.core.lookups.GameType
import com.twobrothers.leaderboard.scores.add.AddScoreActivity
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
    private lateinit var scoresListAdapter: ScoresListAdapter
    private lateinit var addAction: MenuItem

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_scores)

        // Init Action Bar

        // Init view model
        val gameId = this.intent.getStringExtra(EXTRA_GAME_ID) ?: ""
        viewModel = ScoresViewModel(gameId)

        // Init list adapter
        scoresListAdapter = ScoresListAdapter()
        recycler_score_list.apply {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = scoresListAdapter
        }

        // Init view model observers
        viewModel.title.observe(this, Observer {
            this.title = it
        })
        viewModel.gameType.observe(this, Observer {
            if (it == GameType.HIGH_SCORE || it == GameType.LOW_SCORE) {
                setSupportActionBar(toolbar_action_bar)
            }
        })
        viewModel.scores.observe(this, Observer {
            scoresListAdapter.submitList(it)
        })
        viewModel.navigateToCreateScore.observe(this, Observer {
            it.getContentIfNotHandled()?.let {
                startActivity(AddScoreActivity.newIntent(this))
            }
        })
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        super.onCreateOptionsMenu(menu)
        menuInflater.inflate(R.menu.menu_add_score, menu)
        addAction = menu.findItem(R.id.action_add)

        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        super.onOptionsItemSelected(item)
        return when (item.itemId) {
            R.id.action_add -> {
                viewModel.onAddScoreClick()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }


}
