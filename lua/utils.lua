local M = {}

-- Load cached dashboard images
local image_cache = {}
local ok, cached = pcall(require, "dashboard_image_cache")
if ok then
	image_cache = cached
end

local function get_image_dimensions(image_path)
	local handle = io.popen(string.format("identify -format '%%w %%h' '%s' 2>/dev/null", image_path))
	if handle then
		local result = handle:read("*a")
		handle:close()
		local width, height = result:match("(%d+) (%d+)")
		if width and height then
			return tonumber(width), tonumber(height)
		end
	end
	return nil, nil
end

function M.generate_dashboard_images()
	local image_folder = vim.fn.expand("~/Documents/dashboard-pics/")
	local images = vim.fn.glob(image_folder .. "/*.{png,jpg,jpeg,gif}", false, true)

	local cache = {}
	for _, image_path in ipairs(images) do
		local width, height = get_image_dimensions(image_path)
		local chafa_size = "60x17"

		if width and height then
			local aspect_ratio = width / height
			if aspect_ratio < 0.8 then
				chafa_size = "50x35"
			elseif aspect_ratio > 1.5 then
				chafa_size = "70x15"
			end
		end

		local temp_file = "/tmp/chafa_temp_" .. os.time() .. math.random(1000) .. ".txt"
		os.execute(
			string.format(
				"chafa '%s' --format symbols --symbols vhalf --size %s --stretch > %s",
				image_path,
				chafa_size,
				temp_file
			)
		)

		local file = io.open(temp_file, "r")
		if file then
			local result = file:read("*a")
			file:close()
			os.remove(temp_file)

			if result and result ~= "" then
				cache[#cache + 1] = {
					image = result,
					size = chafa_size,
					name = vim.fn.fnamemodify(image_path, ":t"),
				}
				print(string.format("Generated image %d: %s (%s)", #cache,
					vim.fn.fnamemodify(image_path, ":t"), chafa_size))
			end
		end
	end

	local cache_file = vim.fn.stdpath("config") .. "/lua/dashboard_image_cache.lua"
	local file = io.open(cache_file, "w")
	if file then
		file:write("-- Auto-generated dashboard image cache\n")
		file:write("-- Generated on " .. os.date() .. "\n")
		file:write("return {\n")
		for i, data in ipairs(cache) do
			file:write(string.format("  [%d] = {\n", i))
			file:write(string.format("    image = %q,\n", data.image))
			file:write(string.format("    size = %q,\n", data.size))
			file:write(string.format("    name = %q,\n", data.name))
			file:write("  },\n")
		end
		file:write("}\n")
		file:close()
		print("\nSaved " .. #cache .. " images to " .. cache_file)
	end

	-- Reload cache
	package.loaded["dashboard_image_cache"] = nil
	local reload_ok, reload_cached = pcall(require, "dashboard_image_cache")
	if reload_ok then
		image_cache = reload_cached
	end

	return cache
end

function M.get_random_image()
	if #image_cache == 0 then
		return { image = "No images cached. Run :DashboardGenerateImages first.", height = 17 }
	end
	math.randomseed(os.time())
	local selected = image_cache[math.random(#image_cache)]

	if type(selected) == "string" then
		return { image = selected, height = 17 }
	else
		local height = tonumber(selected.size:match("x(%d+)")) or 17
		return { image = selected.image, height = height }
	end
end

function M.setup_dashboard_command()
	vim.api.nvim_create_user_command("DashboardGenerateImages", function()
		M.generate_dashboard_images()
		print("Cache reloaded. Restart nvim to see new images.")
	end, {})
end

function M.copy_filename()
	local filepath = vim.fn.expand("%:t")
	vim.fn.setreg("+", filepath)
	vim.notify("Copied: " .. filepath)
end

function M.copy_relative_path()
	local filepath = vim.fn.expand("%:.")
	vim.fn.setreg("+", filepath)
	vim.notify("Copied: " .. filepath)
end

function M.jump_and_copy_diagnostic(direction)
	-- Jump to diagnostic
	if direction == "next" then
		vim.fn.CocActionAsync("diagnosticNext")
	else
		vim.fn.CocActionAsync("diagnosticPrevious")
	end

	-- Wait for jump, then get current diagnostic info
	vim.defer_fn(function()
		local diagnostics = vim.fn.CocAction("diagnosticList")
		if type(diagnostics) == "table" and #diagnostics > 0 then
			local current_line = vim.fn.line(".")
			local current_col = vim.fn.col(".")

			local best_diagnostic = nil
			local closest_distance = math.huge

			-- Find diagnostic closest to cursor on current line
			for _, diagnostic in ipairs(diagnostics) do
				if type(diagnostic) == "table" and diagnostic.lnum == current_line then
					local distance = math.abs((diagnostic.col or 0) - current_col)
					if distance < closest_distance then
						closest_distance = distance
						best_diagnostic = diagnostic
					end
				end
			end

			if best_diagnostic and best_diagnostic.message then
				local error_message = best_diagnostic.message
				local full_error = string.format(
					"[%s:%d:%d] %s",
					vim.fn.expand("%."),
					best_diagnostic.lnum,
					best_diagnostic.col or 0,
					error_message
				)
				vim.fn.setreg("+", full_error)
				print("Copied: " .. error_message:sub(1, 60) .. "...")
			end
		end
	end, 200)
end

return M
