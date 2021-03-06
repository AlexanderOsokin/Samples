//
//  ZoomTransitionController.swift
//  SearchTest
//
//  Created by Edu user on 16/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

 class ZoomTransitionController: NSObject {

	let animator: ZoomAnimator

	weak var fromDelegate: ZoomAnimatorDelegate?
	weak var toDelegate: ZoomAnimatorDelegate?

	override init() {
		animator = ZoomAnimator()
		super.init()
	}
}

extension ZoomTransitionController: UIViewControllerTransitioningDelegate {
	 func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self.animator.isPresenting = true
		self.animator.fromDelegate = fromDelegate
		self.animator.toDelegate = toDelegate
		return self.animator
	}

	 func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self.animator.isPresenting = false
		let tmp = self.fromDelegate
		self.animator.fromDelegate = self.toDelegate
		self.animator.toDelegate = tmp
		return self.animator
	}
}

extension ZoomTransitionController: UINavigationControllerDelegate {
	 func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

		if operation == .push {
			self.animator.isPresenting = true
			self.animator.fromDelegate = fromDelegate
			self.animator.toDelegate = toDelegate
		} else {
			self.animator.isPresenting = false
			let tmp = self.fromDelegate
			self.animator.fromDelegate = self.toDelegate
			self.animator.toDelegate = tmp
		}

		return self.animator
	}
}
