package com.twobrothers.leaderboard.sports

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.sports.models.Sport


class SportsListAdapter(
    private val onSportClickListener: OnSportClickListener?
) : ListAdapter<Sport, SportsListAdapter.SportsListViewHolder>(SportsListDifferConfig()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SportsListViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.view_sport_item, parent, false)
        return SportsListViewHolder(view)
    }

    override fun onBindViewHolder(holder: SportsListViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class SportsListViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(sport: Sport) {
            itemView.findViewById<TextView>(R.id.text_sport).text = sport.title
            itemView.setOnClickListener {
                onSportClickListener?.onClick(sport.title)
            }
        }
    }

    private class SportsListDifferConfig : DiffUtil.ItemCallback<Sport>() {
        override fun areItemsTheSame(oldItem: Sport, newItem: Sport): Boolean {
            return oldItem.title == newItem.title
        }

        override fun areContentsTheSame(
            oldItem: Sport,
            newItem: Sport
        ): Boolean {
            return oldItem.title == newItem.title
        }
    }

}

interface OnSportClickListener {
    fun onClick(title: String)
}