package com.twobrothers.leaderboard.scores

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.twobrothers.leaderboard.R
import kotlinx.android.synthetic.main.activity_scores.*

class ScoresActivity : AppCompatActivity() {

    private val viewModel: ScoresViewModel = ScoresViewModel()
    private lateinit var scoresListAdapter: ScoresListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sports)

        // Init list adapter
        recycler_score_list.apply {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = scoresListAdapter
        }

        // Init view model observers
        viewModel.scores.observe(this, Observer {
            scoresListAdapter.submitList(it)
        })
    }


}
