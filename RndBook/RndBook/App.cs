using System;

namespace RndBook
{
    public class AppCoordinator
    {
        public static bool UseMockDataStore = false;
        public static string BackendUrl = "https://randomuser.me/";

        public static void Initialize()
        {
            if (UseMockDataStore)
                ServiceLocator.Instance.Register<IDataStore<Item>, MockDataStore>();
            else
                ServiceLocator.Instance.Register<IDataStore<Item>, CloudDataStore>();
        }
    }
}
