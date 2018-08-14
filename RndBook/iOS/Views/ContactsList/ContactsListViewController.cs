using Foundation;
using RndBook.ViewModels;
using System;
using UIKit;

namespace RndBook.iOS
{
    public partial class ContactsListViewController : UITableViewController
    {
        public ContactsViewModel ViewModel { get; set; }

        public ContactsListViewController (IntPtr handle) : base (handle)
        {
        }
        UIRefreshControl refreshControl;


        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            ViewModel = new ContactsViewModel();

            // Setup UITableView.
            refreshControl = new UIRefreshControl();
            refreshControl.ValueChanged += RefreshControl_ValueChanged;
            TableView.Add(refreshControl);
            TableView.Source = new ContactsListTableSource(ViewModel);

            Title = ViewModel.Title;

            ViewModel.PropertyChanged += IsBusy_PropertyChanged;
        }

        public override void ViewDidAppear(bool animated)
        {
            base.ViewDidAppear(animated);

            if (ViewModel.Contacts.Count == 0)
                ViewModel.LoadMode().ContinueWith(t => { InvokeOnMainThread(TableView.ReloadData); });
        }

        public override void PrepareForSegue(UIStoryboardSegue segue, NSObject sender)
        {
            if (segue.Identifier == "NavigateToItemDetailSegue")
            {
                var controller = segue.DestinationViewController as ContactDetailViewController;
                var indexPath = TableView.IndexPathForCell(sender as UITableViewCell);
                var item = ViewModel.Contacts[indexPath.Row];
                controller.ViewModel = new ItemDetailViewModel(item);
            }
        }

        void RefreshControl_ValueChanged(object sender, EventArgs e)
        {
            if (!ViewModel.IsBusy && refreshControl.Refreshing)
                ViewModel.LoadMode(true).ContinueWith(t => { InvokeOnMainThread(TableView.ReloadData); });
        }

        void IsBusy_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            var propertyName = e.PropertyName;
            switch (propertyName)
            {
                case nameof(ViewModel.IsBusy):
                    {
                        InvokeOnMainThread(() =>
                        {
                            if (ViewModel.IsBusy && !refreshControl.Refreshing)
                                refreshControl.BeginRefreshing();
                            else if (!ViewModel.IsBusy)
                                refreshControl.EndRefreshing();
                        });
                    }
                    break;
            }
        }

    }

}