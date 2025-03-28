/*
 * This file is part of EasyRPG Player.
 *
 * EasyRPG Player is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * EasyRPG Player is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with EasyRPG Player. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef EP_WINDOW_SHOP_H
#define EP_WINDOW_SHOP_H

// Headers
#include <string>
#include "window_base.h"

/**
 * Window Shop Class.
 */
class Window_Shop :	public Window_Base {
public:
	/**
	 * Constructor.
	 */
	Window_Shop(int shop_type, int ix, int iy, int iwidth, int iheight);

	/**
	 * Renders the current shop on the window.
	 */
	void Refresh();

	/**
	 * Updates the window.
	 */
	void Update() override;

	void SetMode(int nmode);
	int GetChoice() const;
	void SetChoice(int nchoice);

	enum WindowMessageValues {
		LeftMargin = 8,
		FaceSize = 48,
		RightFaceMargin = 16,
		TopMargin = 8
	};

protected:
	void UpdateCursorRect();

	std::string_view greeting;
	std::string_view regreeting;
	std::string_view buy_msg;
	std::string_view sell_msg;
	std::string_view leave_msg;
	std::string_view buy_select;
	std::string_view buy_number;
	std::string_view purchased;
	std::string_view sell_select;
	std::string_view sell_number;
	std::string_view sold_msg;
	int index;
	int mode;
	int buy_index;
	int sell_index;
	int leave_index;
	int choice;
};

#endif
