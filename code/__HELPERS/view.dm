/proc/getviewsize(view)
	if(isnum(view))
		var/totalviewrange = (view < 0 ? -1 : 1) + 2 * view
		return list(totalviewrange, totalviewrange)
	else
		var/list/viewrangelist = splittext(view,"x")
		return list(text2num(viewrangelist[1]), text2num(viewrangelist[2]))

/// Returns TRUE if the atom is in the user view range.
/proc/in_view_range(mob/user, atom/A)
	var/list/view_range = getviewsize(user.client.view)
	var/turf/source = get_turf(user)
	var/turf/target = get_turf(A)
	var/view_x = round(view_range[1] * 0.5)
	var/view_y = round(view_range[2] * 0.5)
	var/x_offset = round(user.client.pixel_x / 32)
	var/y_offset = round(user.client.pixel_y / 32)
	return ISINRANGE(target.x, source.x - view_x + x_offset, source.x + view_x + x_offset) && ISINRANGE(target.y, source.y - view_y + y_offset, source.y + view_y + y_offset)

///Return the center turf of the user's view
/proc/get_view_center(mob/user)
	var/x_offset = round(user.client.pixel_x / 32)
	var/y_offset = round(user.client.pixel_y / 32)
	return locate(user.x + x_offset, user.y + y_offset, user.z)

/// Takes a string or num view, and converts it to pixel width/height in a list(pixel_width, pixel_height)
/proc/view_to_pixels(view)
	if(!view)
		return list(0, 0)
	var/list/view_info = getviewsize(view)
	view_info[1] *= world.icon_size
	view_info[2] *= world.icon_size
	return view_info
