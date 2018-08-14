using Foundation;
using RndBook.ViewModels;
using System;
using UIKit;

namespace RndBook.iOS
{
    public partial class ContactDetailViewController : UIViewController
    {
        public ItemDetailViewModel ViewModel { get; set; }


        public ContactDetailViewController(IntPtr handle) : base(handle) { }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            Title = ViewModel.Title;
            //ItemNameLabel.Text = ViewModel.Item.Text;
           // ItemDescriptionLabel.Text = ViewModel.Item.Description;
        }
    }
}