package com.twobrothers.leaderboard.sports

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.games.GameActivity
import kotlinx.android.synthetic.main.activity_sports.*

class SportsActivity : AppCompatActivity() {

    private val viewModel: SportsViewModel = SportsViewModel()
    private lateinit var sportsListAdapter: SportsListAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sports)

        // Init list adapter
        sportsListAdapter = SportsListAdapter(object : OnSportClickListener {
            override fun onClick(id: String) {
                viewModel.onSportClick(id)
            }
        })
        recycler_sport_list.apply {
            setHasFixedSize(true)
            layoutManager = LinearLayoutManager(context)
            adapter = sportsListAdapter
        }

        // Init view model observers
        viewModel.sports.observe(this, Observer {
            sportsListAdapter.submitList(it)
        })

        viewModel.navigateToSport.observe(this, Observer {
            it.getContentIfNotHandled()?.let { sportId ->
                startActivity(GameActivity.newIntent(this, sportId))
            }
        })
    }


}
