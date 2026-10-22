import Cocoa

class ThemeMonitor {
	@objc func themeChanged() {
		// print("theme-changed")
		let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
		print(isDark ? "dark" : "light")
		fflush(stdout)
	}

	func start() {
		DistributedNotificationCenter.default.addObserver(
			self,
			selector: #selector(themeChanged),
			name: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
			object: nil
		)
		RunLoop.main.run()
	}
}

let monitor = ThemeMonitor()
monitor.start()
